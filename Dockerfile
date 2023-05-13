FROM python:3.10 AS compile

RUN apt-get update && apt-get -y upgrade
RUN apt-get install -y build-essential gcc

RUN python -m venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /usr/app
COPY requirements.txt .

RUN pip install -r requirements.txt && pip install gunicorn

ADD src/ ./src
ADD setup.py .
RUN python setup.py build_ext --inplace --build-lib ./src/functions
RUN python -m pip install .

FROM python:3.10-slim

COPY --from=compile /opt/venv /opt/venv
ENV PATH="/opt/venv/bin:$PATH"

WORKDIR /usr/app
COPY --from=compile /usr/app/src .

CMD ["python", "./main.py"]