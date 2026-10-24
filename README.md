# Macro-Growth-Project

Data Collection Sources:
For Project_one_P1-P3.r
United Kingdom:
GDP/Capita - https://fred.stlouisfed.org/series/PCAGDPGBA646NWDB
Human Capital - https://fred.stlouisfed.org/series/HCIYISGBA066NRUG
Industrialization - The World Bank World Development Indicators

Slovenia:
GDP/Capita - https://fred.stlouisfed.org/series/PCAGDPSIA646NWDB
Human Capital - https://fred.stlouisfed.org/series/HCIYISSIA066NRUG
Industrialization - The World Bank World Development Indicators

Moldova:
GDP/Capita - https://fred.stlouisfed.org/series/PCAGDPMDA646NWDB
Human Capital - https://fred.stlouisfed.org/series/HCIYISMDA066NRUG
Industrialization - The World Bank World Development Indicators

-Note The variable Industrialization represents the percentage of GDP from services, industry, and agriculture in that respective country
The data was aggregated into a csv file, spanning from 1990-2025. The data for industrialization starting in 1995, and for human capital the data ends in 2023 from lack of available data. 
There are no gaps in the data between the same variables in different countries 

The data for GDP/Capita for each country was converted to rates through log conversion and first differencing

For Project_one_P4.r
OECD Countries Data:
WAGE: https://www.oecd.org/en/data/indicators/average-annual-wages.html
- Data Refinement:
     - Time Period: Past 20 Periods
     - Reference Area: All available countries, excluding country groupings
     - Unit of Measure: US dollars, PPP converted
     - Price Base: Constant prices
       
RGDP: https://www.oecd.org/en/data/indicators/real-gross-domestic-product-gdp.html
- Data Refinement:
     - Time Period: Past 20 Periods
     - Reference Area: All available countries, excluding country groupings
     - Transaction: Gross domestic product
     - Transformation: Growth rate, period on period
     - Frequency: Annual
       
PGR: https://www.oecd.org/en/data/indicators/multifactor-productivity.html
- Note PGR raw data is indexed. In utilization, converted back to rates by subtracting 100
- Data Refinement:
     - Time Period: Past 20 Periods
     - Reference Area: All available countries, excluding country groupings
     - Unit of measure: Index
     - Measure: Multifactor productivity (hours based)
     - Frequency: Annual
       
LFPR: https://www.oecd.org/en/data/indicators/labour-force-participation-rate.html
- Data Refinement:
     - Time Period: Past 20 Periods
     - Reference Area: All available countries, excluding country groupings
     - Measure: Labor force participation rate
     - Sex: Total
     - Age: Total
     - Labor force status: Labor force
       
POP: https://bit.ly/3UMyWcW
-Data Refinement:
      - Time Period: Past 20 Periods
       Reference Area: All available countries, excluding country groupings
       Measure: Population
       Unit of measure: Persons
       Sex: Total
       Age: Total
       
Patent: https://bit.ly/3W188pM
- Data Refinement:
    - Time Period: Past 20 Periods
    - Patent Authorities: World Intellectual Property Organization
    - Unit of Measure: Patents
    - Reference Data Type: Priority date
    - Reference Area: All available countries, excluding country groupings
    - Agent role: Inventor
    - Selected OECD technology domains: Total patents
    - Frequency: Annual

All data utilized for OECD countries converted to country-year values for comparison. 
