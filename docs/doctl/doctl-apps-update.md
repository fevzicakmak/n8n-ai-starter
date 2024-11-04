# doctl apps update | DigitalOcean Documentation

```
doctl apps update <app id> [flags]
```

```
u
```

Updates the specified app with the given app spec. For more information about app specs, see the [app spec reference](https://www.digitalocean.com/docs/app-platform/concepts/app-spec)

## Example

The following example updates an app with the ID `f81d4fae-7dec-11d0-a765-00a0c91e6bf6` using an app spec located in a directory called `/src/your-app.yaml`. Additionally, the command returns the updated app’s ID, ingress information, and creation date:

```
doctl apps update f81d4fae-7dec-11d0-a765-00a0c91e6bf6 --spec src/your-app.yaml --format ID,DefaultIngress,Created
```

## Flags

|  Option |  Description |
|---|---|
|   `--format`  |   Columns for output in a comma-separated list. Possible values: `ID`, `Spec.Name`, `DefaultIngress`, `ActiveDeployment.ID`, `InProgressDeployment.ID`, `Created`, `Updated`.  |  
|   `--help` , `-h`  |   Help for this command  |  
|   `--no-header`  |   Return raw data with no headers <br>Default: `false`  |  
|   `--spec`  |   Path to an app spec in JSON or YAML format. Set to “-” to read from stdin. (required)  |  
|   `--wait`  |   Boolean that specifies whether to wait for an app to complete updating before allowing further terminal input. This can be helpful for scripting. <br>Default: `false`  |  

|  Command |  Description |
|---|---|
|  [doctl apps](https://docs.digitalocean.com/reference/doctl/reference/apps) |  Displays commands for working with apps  | 

## Global Flags

|  Option |  Description |
|---|---|
|   `--access-token`, `-t`  |   API V2 access token  |  
|   `--api-url`, `-u`  |   Override default API endpoint  |  
|   `--config`, `-c`  |   Specify a custom config file <br>Default:  * macOS: `${HOME}/Library/Application Support/doctl/config.yaml`* Linux: `${XDG_CONFIG_HOME}/doctl/config.yaml`* Windows: `%APPDATA%\doctl\config.yaml`⠀  |
|   `--context`  |   Specify a custom authentication context name  |  
|   `--http-retry-max`  |   Set maximum number of retries for requests that fail with a 429 or 500-level error <br>Default: `5`  |  
|   `--http-retry-wait-max`  |   Set the minimum number of seconds to wait before retrying a failed request <br>Default: `30`  |  
|   `--http-retry-wait-min`  |   Set the maximum number of seconds to wait before retrying a failed request <br>Default: `1`  |  
|   `--interactive`  |   Enable interactive behavior. Defaults to true if the terminal supports it (default false) <br>Default: `false`  |  
|   `--output`, `-o`  |   Desired output format [text|json] <br>Default: `text`  |  
|   `--trace`  |   Show a log of network activity while performing a command <br>Default: `false`  |  
|   `--verbose`, `-v`  |   Enable verbose output <br>Default: `false`  |  

Please try using alternative keywords or simplifying your search terms.

[doctl apps update | DigitalOcean Documentation](https://docs.digitalocean.com/reference/doctl/reference/apps/update/)