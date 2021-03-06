# validate_apache_log_level.rb
module Puppet::Parser::Functions
  newfunction(:validate_apache_log_level, doc: <<-DOC
    @summary
      Perform simple validation of a string against the list of known log levels.

    As per http://httpd.apache.org/docs/current/mod/core.html#loglevel
        * validate_apache_loglevel('info')
    Modules maybe specified with their own levels like these:
        * validate_apache_loglevel('warn ssl:info')
        * validate_apache_loglevel('warn mod_ssl.c:info')
        * validate_apache_loglevel('warn ssl_module:info')
    Expected to be used from the main or vhost.
    Might be used from directory too later as apaceh supports that

    @param log_level
      The string that is to be validated.

    @return
      Return's an error if the validation fails.
DOC
             ) do |args|
    if args.size != 1
      raise Puppet::ParseError, "validate_apache_loglevel(): wrong number of arguments (#{args.length}; must be 1)"
    end

    log_level = args[0]
    msg = "Log level '${log_level}' is not one of the supported Apache HTTP Server log levels."
    raise Puppet::ParseError, msg unless log_level =~ Regexp.compile('(emerg|alert|crit|error|warn|notice|info|debug|trace[1-8])')
  end
end
