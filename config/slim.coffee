grunt.initConfig
  slim:                               # Task
    dist:                            # Target
      options:
        pretty: true

      files: [{
        expand: true,
        cwd: 'templates/slim',
        src: ['{,*/}*.slim'],
        dest: 'templates'
        ext: '.html'
      }]

grunt.loadNpmTasks 'grunt-slim'

grunt.registerTask 'default', ['jshint', 'slim']
