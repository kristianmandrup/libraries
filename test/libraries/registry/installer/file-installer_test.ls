    describe 'install(name, path)' ->
      before ->
        registry.install('bootstrap')

      specify 'is installed' ->
        expect 1

    describe 'uninstall(name, path)' ->
      before ->
        registry.uninstall('bootstrap')

      specify 'is uninstalled' ->
        expect 1
