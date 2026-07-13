function Get-RedirectedUrl {
    <#
    .SYNOPSIS
        Resolves the target of an HTTP redirect without following it.

    .DESCRIPTION
        Sends a HEAD request with automatic redirect handling disabled and
        returns the value of the response's Location header. Used to resolve
        "latest" redirect folders (e.g. upstream-provided /latest-.../ links) to
        their versioned target without downloading any content.

    .PARAMETER Url
        The URL expected to respond with an HTTP redirect (e.g. 301/302).

    .EXAMPLE
        Get-RedirectedUrl 'https://example.com/latest/'
    #>
    param ([Parameter(Mandatory = $true)][string]$Url)

    $request = [System.Net.WebRequest]::Create($Url)
    $request.Method = 'HEAD'
    $request.AllowAutoRedirect = $false
    $response = $request.GetResponse()
    try {
        return $response.GetResponseHeader('Location')
    } finally {
        $response.Close()
    }
}
