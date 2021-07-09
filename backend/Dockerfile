FROM google/dart

# command performs mkdir and cd implicitly
WORKDIR /app

ADD pubspec.* /app/
RUN pub get --no-precompile
ADD ./ /app
RUN pub get --offline --no-precompile

EXPOSE 80

ENTRYPOINT ["/usr/bin/dart", "bin/backend.dart"]