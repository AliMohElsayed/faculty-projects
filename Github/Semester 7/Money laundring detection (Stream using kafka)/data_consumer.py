from kafka import KafkaConsumer
import json
import pickle
import numpy as np
import pandas as pd
import os

# Kafka Consumer configuration
consumer = KafkaConsumer(
    'transactions',
    bootstrap_servers=['localhost:9092'],
    auto_offset_reset='earliest',
    value_deserializer=lambda x: json.loads(x.decode('utf-8'))
)

# Load the trained model
with open('money_laundering_model.pkl', 'rb') as file:
    model = pickle.load(file)

# Function to predict transaction status
def predict(transaction):
    # Example features: amount and dummy encoding for countries
    amount = transaction['amount']
    source_country = hash(transaction['source_country']) % 100
    destination_country = hash(transaction['destination_country']) % 100
    features = np.array([amount, source_country, destination_country]).reshape(1, -1)
    prediction = model.predict(features)
    return prediction[0]

# Function to save processed transactions to a CSV file
def save_to_csv(transaction, status):
    file_name = 'processed_transactions.csv'

    # Check if the file exists
    if os.path.exists(file_name):
        # Append to existing file
        df = pd.read_csv(file_name)
    else:
        # Create a new file with headers
        df = pd.DataFrame(columns=['transaction_id', 'name', 'amount', 'source_country', 'destination_country', 'status'])

    # Add the new transaction
    new_row = {
        'transaction_id': transaction.get('transaction_id', 'N/A'),
        'name': transaction.get('name', 'N/A'),
        'amount': transaction.get('amount', 0),
        'source_country': transaction.get('source_country', 'Unknown'),
        'destination_country': transaction.get('destination_country', 'Unknown'),
        'status': status
    }
    df = pd.concat([df, pd.DataFrame([new_row])], ignore_index=True)

    # Save back to the file
    df.to_csv(file_name, index=False)

# Main consumer loop
if __name__ == "__main__":
    print("Starting Kafka Consumer...")
    for message in consumer:
        transaction = message.value
        result = predict(transaction)
        status = "Suspicious" if result == 1 else "Normal"
        print(f"Transaction: {transaction}, Status: {status}")

        # Save the transaction to CSV
        save_to_csv(transaction, status)
