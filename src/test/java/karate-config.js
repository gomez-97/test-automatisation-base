// noinspection JSUnresolvedReference,JSUnusedGlobalSymbols

function fn() {
    const env = karate.env || 'dev';

    const configuration = karate.read('classpath:com/pichincha/core/environment/environment.json')[env];

    if (!configuration) {
        throw new Error(`No configuration found for the environment: ${env}`);
    }

    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    karate.configure('readTimeout', configuration.timeouts?.read || 5000);
    karate.configure('connectTimeout', configuration.timeouts?.connect || 3000);

    return configuration;
}