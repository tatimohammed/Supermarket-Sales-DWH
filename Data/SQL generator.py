import pandas as pd
from copy import deepcopy

data = pd.read_csv('supermarket-database.csv')

# For the Branch & City
df = deepcopy(data[['Branch', 'City']])
df.Branch = df.Branch.map({'A': '1', 'C': '2', 'B': 3})
df.City = df.City.map({'Yangon': '1', 'Naypyitaw': '2', 'Mandalay': 3})
df.drop_duplicates(inplace=True)

# For customer_id & store_id
sale = deepcopy(data)
sale['customer_id'] = None
sale.loc[(sale['Customer type'] == 'Member') & (
    sale['Gender'] == 'Female'), 'customer_id'] = 1
sale.loc[(sale['Customer type'] == 'Member') & (
    sale['Gender'] == 'Male'), 'customer_id'] = 2
sale.loc[(sale['Customer type'] == 'Normal') & (
    sale['Gender'] == 'Female'), 'customer_id'] = 3
sale.loc[(sale['Customer type'] == 'Normal') & (
    sale['Gender'] == 'Male'), 'customer_id'] = 4
sale['store_id'] = None


def store_id(x):
    if x == 'A':
        return 1
    elif x == 'C':
        return 2
    elif x == 'B':
        return 3


sale['store_id'] = sale.Branch.apply(store_id)

# Sccript generator
with open('inserting.sql', 'a') as f:
    m = range(data.shape[0])
    f.write("-- customer:\n\n")
    for t in data['Customer type'].unique():
        for g in data['Gender'].unique():
            f.write(
                "INSERT INTO customer (customer_type, gender) VALUES('"+t+"', '"+g+"');\n")

    f.write("-- product:\n\n")
    for line in m:
        f.write("INSERT INTO product (product_line, unit_price) VALUES('" +
                data['Product line'][line]+"', "+str(data['Unit price'][line])+");\n")

    f.write("-- city:\n\n")
    for city in data['City'].unique():
        f.write("INSERT INTO city (city_name) VALUES('"+city+"');\n")

    f.write("-- branch:\n\n")
    for b in data['Branch'].unique():
        f.write("INSERT INTO branch (branch_letter) VALUES('"+b+"');\n")

    f.write("-- supermarket:\n\n")
    f.write("INSERT INTO supermarket (city_id, branch_id) VALUES(1, 1);\n")
    f.write("INSERT INTO supermarket (city_id, branch_id) VALUES(2, 2);\n")
    f.write("INSERT INTO supermarket (city_id, branch_id) VALUES(3, 3);\n")

    f.write("-- sale:\n\n")
    for line in m:
        c = str(sale['customer_id'][line])
        p = str(line+1)
        s = str(sale['store_id'][line])
        q = str(sale['Quantity'][line])
        ta = str(sale['Tax 5%'][line])
        t = str(sale['Total'][line])
        pa = sale['Payment'][line]
        co = str(sale['cogs'][line])
        gm = str(sale['gross margin percentage'][line])
        g = str(sale['gross income'][line])
        r = str(sale['Rating'][line])
        d = sale['Date'][line]
        ti = sale['Time'][line]
        f.write("INSERT INTO sale (customer_id,product_id,store_id,quantity,tax,total,payment_method,cogs,gross_margin_percentage,gross_income,rating,date,time) VALUES(" +
                c+","+p+","+s+","+q+","+ta+","+t+",'"+pa+"',"+co+","+gm+","+g+","+r+",'"+d+"','"+ti+"');\n")
f.close()
