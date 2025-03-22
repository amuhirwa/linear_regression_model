from fastapi import FastAPI, HTTPException
from pydantic import BaseModel, confloat, conint
import joblib
from fastapi.middleware.cors import CORSMiddleware
import uvicorn
import pandas as pd

app = FastAPI(title="Crop Yield Predictor API")

# CORS Middleware
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_methods=["*"],
    allow_headers=["*"],
)

# Load model and scaler
model = joblib.load('best_model.joblib')
preprocessor = joblib.load('preprocessor.joblib')

class CropInput(BaseModel):
    Area: str
    Item: str
    Year: conint(ge=1900, le=2050)
    average_rain_fall_mm_per_year: confloat(ge=0, le=10000)
    pesticides_tonnes: confloat(ge=0)
    avg_temp: confloat(ge=-20, le=50)

@app.post('/predict_yield')
def predict_yield(input_data: CropInput):
    try:
        # Convert input to DataFrame
        input_df = pd.DataFrame([input_data.dict()])
        
        # Preprocess
        processed_input = preprocessor.transform(input_df)
        
        # Predict
        prediction = model.predict(processed_input)
        
        return {"predicted_yield": prediction[0]}
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))
    
if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=10000)
