FROM ruby:2.5.1

WORKDIR /usr/src/app

# For Node.js
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -

RUN apt-get update \
 && apt-get install -y \
    mysql-client \
    nodejs \
    build-essential \
    vim \
    zip \
    unzip \
    rsync \
    --no-install-recommends && \
    rm -rf /var/lib/apt/lists/*

# Install yarn
RUN curl -o- -L https://yarnpkg.com/install.sh | bash
ENV PATH="/root/.yarn/bin:$PATH"
ENV LANG=ja_JP.UTF-8

COPY Gemfile Gemfile.lock /usr/src/app/
RUN bundle install --system

COPY . /usr/src/app

RUN chmod 755 /usr/src/app/bin
RUN jets webpacker:install

EXPOSE 8888
CMD bin/start_server.sh
