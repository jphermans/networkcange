Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

function Get-NetworkCategory {
    try {
        return (Get-NetConnectionProfile).NetworkCategory
    } catch {
        return "Unknown"
    }
}

function Set-NetworkCategory($category) {
    try {
        Set-NetConnectionProfile -NetworkCategory $category
        [System.Windows.Forms.MessageBox]::Show("Network profile changed to $category.", "Success", 'OK', 'Information')
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Failed to change network profile. Administrator privileges required.", "Error", 'OK', 'Error')
    }
}

$form = New-Object System.Windows.Forms.Form
$form.Text = "Network Profile Manager"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"
$form.FormBorderStyle = 'FixedDialog'
$form.MaximizeBox = $false

$label = New-Object System.Windows.Forms.Label
$label.Text = "Current network profile: $(Get-NetworkCategory)"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(30,30)
$form.Controls.Add($label)

$btnPrivate = New-Object System.Windows.Forms.Button
$btnPrivate.Text = "Private"
$btnPrivate.Location = New-Object System.Drawing.Point(30,70)
$btnPrivate.Add_Click({
    Set-NetworkCategory "Private"
    $label.Text = "Current network profile: $(Get-NetworkCategory)"
})
$form.Controls.Add($btnPrivate)

$btnPublic = New-Object System.Windows.Forms.Button
$btnPublic.Text = "Public"
$btnPublic.Location = New-Object System.Drawing.Point(150,70)
$btnPublic.Add_Click({
    Set-NetworkCategory "Public"
    $label.Text = "Current network profile: $(Get-NetworkCategory)"
})
$form.Controls.Add($btnPublic)

$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Exit"
$btnExit.Location = New-Object System.Drawing.Point(270,70)
$btnExit.Add_Click({
    $form.Close()
})
$form.Controls.Add($btnExit)

[void]$form.ShowDialog()
