FROM nvcr.io/nvidia/pytorch:23.01-py3
WORKDIR /workspace
USER root
EXPOSE 8800
ARG DEBIAN_FRONTEND=noninteractive
ENV TZ=Asia/Shanghai
RUN apt-get update && apt-get upgrade -y && apt-get install git -y && apt-get install ffmpeg -y
RUN apt-get install -y vim && apt-get install -y gcc && apt-get install -y g++ && apt-get install -y cmake

# Keeps Python from generating .pyc files in the container
# ENV PYTHONDONTWRITEBYTECODE=1
# Turns off buffering for easier container logging
ENV PYTHONUNBUFFERED=1

COPY . /workspace
# Install pip requirements
RUN pip install -r requirements.txt
RUN cd monotonic_align && python setup.py build_ext --inplace 
ENTRYPOINT ["jupyter-lab","--no-browser","--allow-root","--port=8800","--ip=0.0.0.0"]
