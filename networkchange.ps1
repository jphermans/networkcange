Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Functie: Huidige netwerkstatus ophalen
function Get-NetworkCategory {
    try {
        return (Get-NetConnectionProfile).NetworkCategory
    } catch {
        return "Onbekend"
    }
}

# Functie: Netwerkprofiel wijzigen
function Set-NetworkCategory($category) {
    try {
        Set-NetConnectionProfile -NetworkCategory $category
        [System.Windows.Forms.MessageBox]::Show("Netwerkprofiel gewijzigd naar $category.", "Succes", 'OK', 'Information')
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Kon netwerkprofiel niet wijzigen. Administratorrechten vereist.", "Fout", 'OK', 'Error')
    }
}

# Hoofdvenster
$form = New-Object System.Windows.Forms.Form
$form.Text = "Netwerkprofielbeheer"
$form.Size = New-Object System.Drawing.Size(400,200)
$form.StartPosition = "CenterScreen"

# Label
$label = New-Object System.Windows.Forms.Label
$label.Text = "Huidig netwerkprofiel: $(Get-NetworkCategory)"
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(30,30)
$form.Controls.Add($label)

# Knop: Instellen op Private
$btnPrivate = New-Object System.Windows.Forms.Button
$btnPrivate.Text = "Zet op Private"
$btnPrivate.Location = New-Object System.Drawing.Point(30,70)
$btnPrivate.Add_Click({
    Set-NetworkCategory "Private"
    $label.Text = "Huidig netwerkprofiel: $(Get-NetworkCategory)"
})
$form.Controls.Add($btnPrivate)

# Knop: Instellen op Public
$btnPublic = New-Object System.Windows.Forms.Button
$btnPublic.Text = "Zet op Public"
$btnPublic.Location = New-Object System.Drawing.Point(150,70)
$btnPublic.Add_Click({
    Set-NetworkCategory "Public"
    $label.Text = "Huidig netwerkprofiel: $(Get-NetworkCategory)"
})
$form.Controls.Add($btnPublic)

# Exit-knop
$btnExit = New-Object System.Windows.Forms.Button
$btnExit.Text = "Sluiten"
$btnExit.Location = New-Object System.Drawing.Point(270,70)
$btnExit.Add_Click({
    $form.Close()
})
$form.Controls.Add($btnExit)

# Start GUI
[void]$form.ShowDialog()
