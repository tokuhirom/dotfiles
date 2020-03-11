# init

    gradle init --type java-library

# fat jar

    jar {
        manifest {
            attributes 'Implementation-Title': project.name,
            'Implementation-Version': version,
            "Premain-Class": "me.geso.jolokia_jvm_agent_retry.JvmAgent"
        }

        from {
            configurations.compile.collect { it.isDirectory() ? it : zipTree(it) }
        }
    }

# skip tests

gradle build -x test 

