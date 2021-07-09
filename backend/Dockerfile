FROM google/dart

# command performs mkdir and cd implicitly
WORKDIR /backend

ADD pubspec.* /backend/
RUN pub get --no-precompile
ADD ./ /backend
RUN pub get --offline --no-precompile

EXPOSE 80

ENTRYPOINT ["/usr/bin/dart", "bin/backend.dart"]