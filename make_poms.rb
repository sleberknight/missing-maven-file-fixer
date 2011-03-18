# Breakdown of JAR file paths relative to Maven repository root directory:
#
# org/springframework/spring-core/3.0.5.RELEASE/spring-core-3.0.5.RELEASE.jar
#
# groupId is org.springframework
# artifactId is spring-core
# version is 3.0.5.RELEASE
#
# This script goes in the Maven repository root directory, alongside add-missing-poms.sh

def run
  Dir.glob "**/*.jar" do |jar_file|
    unless jar_file =~ /(sources|javadoc).jar/
      pom_file = jar_file.gsub(/jar$/, "pom")
      unless File.exist?(pom_file)
        parts = jar_file.split('/')
        group_id = parts[0..-4].join('.')
        artifact_id = parts[-3]
        version = parts[-2]
        pom_content = make_pom(group_id, artifact_id, version)
        puts "Creating POM #{pom_file}"
        write_pom(pom_file, pom_content)
      end
    end
  end
end

def make_pom(group_id, artifact_id, version)
  %Q{<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0"
    xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/maven-v4_0_0.xsd">
  <modelVersion>4.0.0</modelVersion>
  <groupId>#{group_id}</groupId>
  <artifactId>#{artifact_id}</artifactId>
  <version>#{version}</version>
</project>
}
end

def write_pom(name, content)
  File.open(name, 'w') do |file|
    file.write(content)
  end
end

run
