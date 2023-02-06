import pandas as pd

data = pd.read_csv('supermarket_sales - data.csv')

# Unique values
cols = ['Branch', 'City', 'Customer type', 'Product line', 'Payment']
for col in cols:
    print("- "+col+":")
    print(data[col].unique())
    print("---------------------------")


# split data
# For Postgresql database
df1 = data.iloc[:500,:]

# For the CSV file
df2 = data.iloc[500:,:]

# Generating the CSVs
df1.to_csv('supermarket-database.csv', index=False)
df2.to_csv('supermarket-data.csv', index=False)