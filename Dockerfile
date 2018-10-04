FROM mhart/alpine-node:10
LABEL maintainer="kurosame"

# Install Digdag
RUN apk update && \
  apk add curl openjdk8
RUN curl -o /home/bot/bin/digdag --create-dirs -L "https://dl.digdag.io/digdag-latest" && \
  chmod +x /home/bot/bin/digdag
ENV PATH /home/bot/bin:$PATH

# Add user bot
RUN npm install -g yo generator-hubot && \
  adduser -S bot && \
  addgroup bot && \
  chown -R bot:bot /home/bot

# Install Hubot
USER bot
WORKDIR /home/bot
RUN yo hubot --defaults && \
  npm install hubot-chatwork && \
  rm -rf hubot-scripts.json

COPY --chown=bot:bot scripts /home/bot/scripts

CMD bin/hubot -a chatwork
