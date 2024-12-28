from kafka import KafkaProducer
import json
from faker import Faker
import time

fake = Faker()

producer = KafkaProducer(
    bootstrap_servers=['localhost:9092'],
    value_serializer=lambda x: json.dumps(x).encode('utf-8')
)

def generate_transaction():
    return {
        'transaction_id': fake.uuid4(),
        'name': fake.name(),
        'amount': fake.random_int(min=10, max=10000),
        'source_country': fake.country(),
        'destination_country': fake.country(),
        'timestamp': fake.date_time().isoformat()
    }

if __name__ == "__main__":
    while True:
        transaction = generate_transaction()
        producer.send('transactions', value=transaction)
        print(f"Sent: {transaction}")
        time.sleep(0.1)
