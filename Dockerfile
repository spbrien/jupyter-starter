FROM python:3

WORKDIR /usr/src/app

RUN apt update
RUN apt install -y curl
RUN curl https://sh.rustup.rs -sSf | sh -s -- -y
RUN apt install -y pandoc
RUN apt install -y texlive-xetex texlive-fonts-recommended texlive-plain-generic


ENV PATH="/root/.cargo/bin:${PATH}"

RUN pip install nltk
RUN python -m nltk.downloader all

COPY requirements.txt /usr/src/requirements.txt
RUN pip install --no-cache-dir -r /usr/src/requirements.txt


ENV PATH="/root/.local/bin:$PATH"
ENV JUPYTER_ENABLE_LAB=yes

EXPOSE 8888

CMD [ \
    "jupyter", \ 
    "lab", \
    "--allow-root", \
    "--port=8888", \
    "--no-browser", \
    "--ip=0.0.0.0", \
    "--NotebookApp.token=''", \ 
    "--NotebookApp.password=''" \
]
