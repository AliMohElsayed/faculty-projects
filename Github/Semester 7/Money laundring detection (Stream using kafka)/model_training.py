import pandas as pd
import numpy as np
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import train_test_split
from sklearn.metrics import accuracy_score
import pickle

# Generate fake data for training
def generate_training_data(num_samples=10000):
    from faker import Faker
    fake = Faker()
    data = []
    for _ in range(num_samples):
        amount = fake.random_int(min=10, max=10000)
        source_country = hash(fake.country()) % 100
        destination_country = hash(fake.country()) % 100
        label = 1 if amount > 9000 or source_country == destination_country else 0  # Example rule
        data.append([amount, source_country, destination_country, label])
    return pd.DataFrame(data, columns=['amount', 'source_country', 'destination_country', 'label'])

# Train the model
if __name__ == "__main__":
    data = generate_training_data()
    X = data[['amount', 'source_country', 'destination_country']]
    y = data['label']

    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2, random_state=42)
    model = RandomForestClassifier()
    model.fit(X_train, y_train)

    # Test the model
    y_pred = model.predict(X_test)
    print(f"Accuracy: {accuracy_score(y_test, y_pred)}")

    # Save the model
    with open('money_laundering_model.pkl', 'wb') as file:
        pickle.dump(model, file)
