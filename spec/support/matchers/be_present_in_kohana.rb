RSpec::Matchers.define :be_present_in_kohana do
  match do |file_name|
    File.exists?(File.join(KohanaScaffold::Test.application_path, file_name)).should be_true
  end

  failure_message_for_should do |file_name|
    "expected that #{file_name} file is present in Kohana project"
  end

  failure_message_for_should_not do |file_name|
    "expected that #{file_name} file is not present in Kohana project"
  end
end
