{ region ? "us-east-1"
, accessKeyId ? "testing"
, ...
}:
{
  resources.dataLifecycleManager.testDataLifecycleManager =
    {
      inherit region accessKeyId;
      name = "dlm-test";
      description = "some description";
      executionRole = "AWSDataLifecycleManagerDefaultRole";
      resourceTypes = "instance";
      targetTags.foo = "bar";
      excludeBootVolume = true;
      copyTags = true;
      tagsToAdd.bar = "stuff";
    };
}
