from conect import coneccion
import pandas as pd
import matplotlib.pyplot as plot

df = pd.read_csv('aux_venta_precio_202211100309.csv')

dfx = df.precio

dfy = df.id

#plot.hist(dfx, dfy)
#plot.show()

#plot.hist(x=dfx, bins=70, rwidth=1)
#plot.show()

df1 = pd.read_csv('aux_venta_cantidad_202211101444.csv')

df1x = df1['suma_ventas']

plot.hist(x=df1x, bins=70, rwidth=1)

plot.show()