{ config, lib, uuid, name, ... }:

with lib;

{
  options = {

    # Global zabbix auth options that can be migrated to a seperate file
    # if another resource is to be supported

    # this will be in a similar way to how aws backend get the creds by specifying accessKeyId
    zabbixAuthUser = mkOption {
      default = "";
      type = types.str;
      description = "zabbix user and it's associated password used to perform operations";
    };

    zabbixAddress = mkOption {
      default = "";
      example = "https://zabbix.nixops.com";
      type = types.str;
      description = "Zabbix URL address.";
    };

    # Host specific options
    hostName = mkOption {
      # apply something somethibg
      type = types.str;
      description = ''
        Zabbix hostname that should be similar to the
        client hostname in the server to be monitored
      '';
    };

    description = mkOption {
      default = "";
      type = types.str;
      description = ''
        Zabbix host descriptions
      '';
    };

    groups = mkOption {
      default = [ "Discovered hosts" ];
      type = with types; listOf str;
      description = "List of groups the host will be part of";
    };

    tempaltes = mkOption {
      default = [];
      type = with types; listOf str;
      description = "List of items and triggers that will be applied to the zabbix host.";
    };

    agentInterfaces = mkOption {
      default = [];
      description = "agent Interfaces to be created for the host.";
      type = with types; listOf (submodule {
        options = {
          IpAddress = mkOption {
            # apply something somehing
            default = "127.0.0.1";
            type = types.str;
            description = "The IP address zabbix will use to contact the agent";
          };
          DnsName = mkOption {
            default = "";
            type = types.str;
            description = "The Dns record zabbix server will use to contact the agent";
          };
          ConnectTo = mkOption {
            default = "IP";
            type = types.enum[ "IP" "DNS" ];
            description = "The method zabbix will use to contact the agent";
          };
          port = mkOption {
            default = 10050;
            type = types.int;
            description = "The port Zabbix will use to connect to the agent";
          };
        };
      });
    };
  };
  config._type = "zabbix-host";
}
