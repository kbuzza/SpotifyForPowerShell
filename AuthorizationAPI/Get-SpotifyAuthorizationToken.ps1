function Get-SpotifyAuthorizationToken {
    <#
        .SYNOPSIS
            This function generates a spotify authorization token using the users Application Client Id and Redirect URI.
            It will load a form and use that to generate an auth token. The PageLoadTime variable can be adjusted after
            testing how long this form takes to fully load on the users personal computer.

            Note: The first time running this function may prompt the user to enter their Spotify username and password, but
            this should be a one-time process for an individual device.
    
        .EXAMPLE
            C:\Users\kbuzz> Get-SpotifyAuthorizationToken
    #>
    
    Add-Type -AssemblyName System.Windows.Forms

    $AuthUri = "https://accounts.spotify.com/en/authorize?" +
               "client_id=$ClientId" +
               "&redirect_uri=$RedirectUri" +
               "&scope=playlist-modify-public playlist-modify-private playlist-read-private playlist-read-collaborative user-library-read user-library-modify user-modify-playback-state user-read-playback-state user-top-read user-read-email user-read-private user-read-birthdate user-follow-read user-follow-modify user-read-recently-played" +
               "&response_type=token"

    $FormProperties = @{
        Size = New-Object System.Drawing.Size(850, 100)
        StartPosition = "CenterScreen" 
    }

    $Form = New-Object 'System.Windows.Forms.Form' -Property $FormProperties
    $Timer = New-Object 'System.Windows.Forms.Timer'
    $InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'

    $Form_Load = {	
    	$TotalTime = $PageLoadTime
    	$script:StartTime = (Get-Date).AddSeconds($TotalTime)
    	$Timer.Start()
    }

    $Timer_Tick = {
    	[TimeSpan]$span = $script:StartTime - (Get-Date)
    
    	if ($span.TotalSeconds -le 0) {
    		$Timer.Stop()
    		$Form.Close()
    	}
    }

    $Form_StateCorrection_Load = {
    	$Form.WindowState = $InitialFormWindowState
    }

    $Form_Cleanup_FormClosed = {
    	try {
    		$Form.remove_Load($Form_Load)
    		$Timer.remove_Tick($Timer_Tick)
    		$Form.remove_Load($Form_StateCorrection_Load)
    		$Form.remove_FormClosed($Form_Cleanup_FormClosed)
    	} catch [Exception] {}
    }

    $Form.SuspendLayout()
    $Form.ClientSize = '400, 80'
    $Form.Name = 'Generating Authorization Token...'
    $Form.Text = 'Generating Authorization Token...'

    $BrowserProperties = @{
        Dock = "Fill"
    }

    $Browser = New-Object System.Windows.Forms.WebBrowser -Property $BrowserProperties
    $Form.Controls.Add($Browser)
    $Browser.Navigate($AuthUri)
    $Form.Add_Shown({$Form.Activate()})
    $Form.add_Load($Form_Load)

    $Timer.add_Tick($Timer_Tick)

    $Form.ResumeLayout()

    $InitialFormWindowState = $Form.WindowState

    $Form.add_Load($Form_StateCorrection_Load)
    $Form.add_FormClosed($Form_Cleanup_FormClosed)
    $Form.ShowDialog() | Out-Null

    $authToken = $Browser.Url.Fragment
    $authToken = $authToken.Substring($authToken.IndexOf('=') + 1, $authToken.IndexOf('&') - $authToken.IndexOf('=') - 1)
    
    return $authToken
}