from fastapi import FastAPI

app = FastAPI()


@app.get("/")
def read_root():
    return {"message": "Hello, World! Deployed to AWS."}


# @app.get("/new-feature")
# def new_feature():
#    return {"message": "This is the new feature."}
