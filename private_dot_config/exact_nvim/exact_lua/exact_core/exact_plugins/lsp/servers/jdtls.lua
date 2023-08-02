local home = os.getenv("HOME")

return {
  java = {
    format = {
      settings = {
        -- Use Google Java style guidelines for formatting
        -- To use, make sure to download the file from https://github.com/google/styleguide/blob/gh-pages/eclipse-java-google-style.xml
        -- and place it in the ~/.local/share/eclipse directory
        url = "/.local/share/eclipse/eclipse-java-google-style.xml",
        profile = "GoogleStyle",
      },
    },
    signatureHelp = { enabled = true },
    contentProvider = { preferred = "fernflower" }, -- Use fernflower to decompile library code
    -- Specify any completion options
    completion = {
      favoriteStaticMembers = {
        "org.hamcrest.MatcherAssert.assertThat",
        "org.hamcrest.Matchers.*",
        "org.hamcrest.CoreMatchers.*",
        "org.junit.jupiter.api.Assertions.*",
        "java.util.Objects.requireNonNull",
        "java.util.Objects.requireNonNullElse",
        "org.mockito.Mockito.*",
      },
      filteredTypes = {
        "com.sun.*",
        "io.micrometer.shaded.*",
        "java.awt.*",
        "jdk.*",
        "sun.*",
      },
    },
    -- Specify any options for organizing imports
    sources = {
      organizeImports = {
        starThreshold = 9999,
        staticStarThreshold = 9999,
      },
    },
    -- How code generation should act
    codeGeneration = {
      toString = {
        template = "${object.className}{${member.name()}=${member.value}, ${otherMembers}}",
      },
      hashCodeEquals = {
        useJava7Objects = true,
      },
      useBlocks = true,
    },
    -- If you are developing in projects with different Java versions, you need
    -- to tell eclipse.jdt.ls to use the location of the JDK for your Java version
    -- See https://github.com/eclipse/eclipse.jdt.ls/wiki/Running-the-JAVA-LS-server-from-the-command-line#initialize-request
    -- And search for `interface RuntimeOption`
    -- The `name` is NOT arbitrary, but must match one of the elements from `enum ExecutionEnvironment` in the link above
    configuration = {
      runtimes = {
        {
          name = "JavaSE-17",
          path = home .. "/.asdf/installs/java/temurin-jre-17.0.7+7",
        },
      },
    },
  },
}
