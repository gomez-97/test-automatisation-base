// noinspection JSUnresolvedReference


function step() {
    const buildPayload = (name) => {
        const Faker = Java.type('net.datafaker.Faker');
        const faker = new Faker();

        return {
            "name": name ?? faker.expression('#{superhero.name}'),
            "alterego": faker.expression('#{superhero.name}'),
            "description": faker.expression('#{job.title}'),
            "powers": [faker.expression('#{superhero.power}'), faker.expression('#{superhero.power}')]
        }
    }

    const buildEmptyPayload = () => ({
        "name": "", "alterego": "", "description": "", "powers": []
    })


    return {
        buildPayload,
        buildEmptyPayload,
    };
}
