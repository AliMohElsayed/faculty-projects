import streamlit as st
import pandas as pd
import matplotlib.pyplot as plt
import seaborn as sns
import numpy as np
import plotly.express as px

st.title("Money Laundering Detection Dashboard")

# Load processed transactions
def load_data():
    try:
        return pd.read_csv('processed_transactions.csv')  # Assuming you save results to a CSV
    except FileNotFoundError:
        return pd.DataFrame(columns=['transaction_id', 'name', 'amount', 'source_country', 'destination_country', 'status', 'transaction_date'])

data = load_data()

if data.empty:
    st.warning("No transactions available at the moment. Please check back later.")
else:
    st.dataframe(data)

    # Filter by Country
    country = st.selectbox("Filter by Country", options=['All'] + list(data['source_country'].unique()))
    if country != 'All':
        filtered_data = data[data['source_country'] == country]
    else:
        filtered_data = data

    # Filter by Status
    status = st.selectbox("Filter by Status", options=['All'] + list(data['status'].unique()))
    if status != 'All':
        filtered_data = filtered_data[filtered_data['status'] == status]

    st.write("Filtered Results", filtered_data)

    # Status Distribution (Pie Chart)
    st.subheader("Status Distribution")
    status_counts = filtered_data['status'].value_counts()
    if not status_counts.empty:
        fig, ax = plt.subplots()
        ax.pie(status_counts, labels=status_counts.index, autopct='%1.1f%%', startangle=90, colors=['#66b3ff', '#ff6666'])
        ax.axis('equal')
        ax.set_title("Transaction Status Distribution")
        st.pyplot(fig)
    else:
        st.warning("No data available to visualize status distribution.")

    # Amount Distribution (Histogram)
    st.subheader("Amount Distribution")
    if not filtered_data['amount'].empty:
        fig, ax = plt.subplots()
        sns.histplot(filtered_data['amount'], bins=30, kde=True, ax=ax, color='skyblue')
        ax.set_title("Transaction Amount Distribution")
        ax.set_xlabel("Amount")
        ax.set_ylabel("Frequency")
        st.pyplot(fig)
    else:
        st.warning("No data available to visualize amount distribution.")


    # Suspicious Transaction Patterns
    st.subheader("Suspicious Transaction Patterns")
    # Example: Frequent small transactions
    small_transactions = filtered_data[filtered_data['amount'] < 100]
    if not small_transactions.empty:
        st.write(f"Frequent small transactions (less than 100 units): {len(small_transactions)} transactions.")
        st.write(small_transactions)

    # Geographical Analysis (Transaction Map)
    st.subheader("Geographical Analysis: Transaction Locations")
    if 'source_country' in filtered_data.columns and 'destination_country' in filtered_data.columns:
        # Create a simple map of source and destination country transactions
        fig = px.scatter_geo(filtered_data, locations="source_country", locationmode="country names", color="status",
                             title="Transaction Locations by Source Country")
        st.plotly_chart(fig)
    else:
        st.warning("No geographical data available for mapping.")
