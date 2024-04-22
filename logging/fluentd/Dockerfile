FROM fluent/fluentd:v1.16-2
USER root
RUN ["gem", "install", "fluent-plugin-elasticsearch", "--no-document"]
RUN ["gem", "install", "fluent-plugin-grok-parser", "--no-document", "--version", "2.1.1"]
ADD fluent.conf /fluentd/etc
USER fluent
