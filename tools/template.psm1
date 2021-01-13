<#
    ______      _      _             _  ___  ___          _       _
    | ___ \    (_)    | |           | | |  \/  |         | |     | |
    | |_/ /_ __ _  ___| | _____  ___| |_| .  . | ___   __| |_   _| | ___
    | ___ \ '__| |/ __| |/ / __|/ _ \ __| |\/| |/ _ \ / _` | | | | |/ _ \
    | |_/ / |  | | (__|   <\__ \  __/ |_| |  | | (_) | (_| | |_| | |  __/
    \____/|_|  |_|\___|_|\_\___/\___|\__\_|  |_/\___/ \__,_|\__,_|_|\___|

#>

# --- Clean up bricksetConnection variable on module remove
$ExecutionContext.SessionState.Module.OnRemove = {

    Remove-Variable -Name bricksetConnection -Force -ErrorAction SilentlyContinue

}