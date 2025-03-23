# Crop Yield Prediction App
## **Mission**:
**Enable precision agriculture by predicting optimal crops and yields, helping farmers:**
- Reduce resource waste (water, pesticides, fertilizers)
- Anticipate climate impact on harvests
- Choose high-yield crops for their specific region
- Improve profitability through data-driven decisions
## **Dataset Description**:

**Source**: Crop Yield Prediction Dataset from Kaggle
https://www.kaggle.com/datasets/mrigaankjaswal/crop-yield-prediction-dataset

This dataset contains 28,242 entries with 7 features tracking agricultural production and environmental factors across 101 countries from 1990-2019. 

**Key Features**:
- Area (Country): Categorical (101 unique countries)
- Item: Crop type (22 different crops including Wheat, Maize, Rice)
- Year: Harvest year (1990-2019)
- hg/ha_yield: Crop yield in hectograms per hectare (target variable)
- average_rain_fall_mm_per_year: Annual rainfall in millimeters
- pesticides_tonnes: Pesticide usage in metric tonnes 
- avg_temp: Annual average temperature in Celsius

Analysis Objectives:
1. Identify key yield drivers through environmental factors
2. Develop predictive models for agricultural yield
3. Enable data-driven farming decisions


## **API**:
**Prediction endpoint**(POST): https://crop-yield-predictor-rb5g.onrender.com/predict/

**Swagger endpoint**: https://crop-yield-predictor-rb5g.onrender.com/docs/
