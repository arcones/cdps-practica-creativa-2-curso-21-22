FROM python:3.7.7-slim

EXPOSE 9080

RUN apt-get update && apt-get install -y git psmisc figlet curl

COPY requirements.txt setupNLaunchBookStore.py ./

RUN pip install -r requirements.txt 

ENTRYPOINT python setupNLaunchBookStore.py --port 9080