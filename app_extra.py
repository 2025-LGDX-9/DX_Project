from fastapi import APIRouter, UploadFile, File
from fastapi.responses import JSONResponse
import os

router = APIRouter()

UPLOAD_DIR = "upload_images"
os.makedirs(UPLOAD_DIR, exist_ok=True)

@router.post("/image-data")
async def single_image(file: UploadFile = File(...)):
    file_path = os.path.join(UPLOAD_DIR, file.filename)
    with open(file_path, "wb") as f:
        f.write(await file.read())
    return {"status": "success", "filename": file.filename}

@router.get("/")
async def index():
    return "hello"

@router.get("/get-data")
async def getData(data: str):
    return {"보내준 데이터": data}

@router.post("/post-data")
async def postData(dataModel: dict):
    return {"보내준 데이터는": dataModel.get("data")}
