	Add-Type -AssemblyName System.Windows.Forms
	Add-Type -AssemblyName System.Drawing
	
	[System.Windows.Forms.Application]::EnableVisualStyles()
	$formКрестикиНолики = New-Object 'System.Windows.Forms.Form'
	$label2 = New-Object 'System.Windows.Forms.Label'
	$button9 = New-Object 'System.Windows.Forms.Button'
	$buttonO = New-Object 'System.Windows.Forms.Button'
	$buttonX = New-Object 'System.Windows.Forms.Button'
	$label1 = New-Object 'System.Windows.Forms.Label'
	$button8 = New-Object 'System.Windows.Forms.Button'
	$button7 = New-Object 'System.Windows.Forms.Button'
	$button6 = New-Object 'System.Windows.Forms.Button'
	$button5 = New-Object 'System.Windows.Forms.Button'
	$button4 = New-Object 'System.Windows.Forms.Button'
	$button3 = New-Object 'System.Windows.Forms.Button'
	$button2 = New-Object 'System.Windows.Forms.Button'
	$button1 = New-Object 'System.Windows.Forms.Button'
	$InitialFormWindowState = New-Object 'System.Windows.Forms.FormWindowState'
	
	$formКрестикиНолики_Load = {
		function global:NewGame
		{
			$label2.text = "Выбор не сделан"
			$buttonX.Text = "X"
			$buttonO.Text = "O"
			$global:player = $null
			$global:pc = $null
			$global:buttons = @($button1, $button2, $button3, $button4, $button5, $button6, $button7, $button8, $button9)
			[int[]]$global:result = @()
			[int[]]$global:resultpc = @()
			$global:pct = [System.Collections.Generic.List[int]](1 .. 9)
			$global:randpct = $null
			foreach ($button in $buttons)
			{
				$button.Text = ""
				$button.Enabled = $false
			}
			$buttonX.Enabled = $true
			$buttonO.Enabled = $true
		}
		
		function global:CheckWin($result)
		{
			$winningCombos = @(@(1, 2, 3), @(4, 5, 6), @(7, 8, 9),
				@(1, 4, 7), @(2, 5, 8), @(3, 6, 9),
				@(1, 5, 9), @(3, 5, 7))
			
			foreach ($combo in $winningCombos)
			{
				$found = $true
				foreach ($num in $combo)
				{
					if (-not ($result -contains $num))
					{
						$found = $false
						break
					}
				}
				if ($found)
				{
					return $true
				}
			}
			return $false
		}
		
		function global:CheckPcWin($resultpc)
		{
			$winningCombos = @(@(1, 2, 3), @(4, 5, 6), @(7, 8, 9),
				@(1, 4, 7), @(2, 5, 8), @(3, 6, 9),
				@(1, 5, 9), @(3, 5, 7))
			
			foreach ($combo in $winningCombos)
			{
				$found = $true
				foreach ($num in $combo)
				{
					if (-not ($resultpc -contains $num))
					{
						$found = $false
						break
					}
				}
				if ($found)
				{
					return $true
				}
			}
			return $false
		}
		NewGame
	}
	
	$buttonX_Click = {
		$buttonO.Enabled = $false
		$buttonX.Enabled = $false
		foreach ($button in $buttons)
		{
			$button.Text = ""
			$button.Enabled = $true
		}
		$global:player = $buttonX.text
		$global:pc = $buttonO.Text
		$label2.Text="Вы выбрали: "+$global:player
	}
	
	$buttonO_Click = {
		$buttonO.Enabled = $false
		$buttonX.Enabled = $false
		foreach ($button in $buttons)
		{
			$button.Text = ""
			$button.Enabled = $true
		}
		$global:player = $buttonO.text
		$global:pc = $buttonX.text
		$label2.Text = "Вы выбрали: " + $global:player
		$global:randpct = $pct | Get-Random
		$buttons[$randpct - 1].Text = $pc
		$buttons[$randpct - 1].Enabled = $false
		$pct.Remove($randpct)
		$global:resultpc += $randpct
	}
	
	$button1_Click = {
		$button1.Enabled = $false
		$button1.Text = $player
		$global:result += 1
		$global:pct.Remove(1)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button2_Click = {
		$button2.Enabled = $false
		$button2.Text = $player
		$global:result += 2
		$global:pct.Remove(2)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				global:NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button3_Click = {
		$button3.Enabled = $false
		$button3.Text = $player
		$global:result += 3
		$global:pct.Remove(3)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				global:NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button4_Click = {
		$button4.Enabled = $false
		$button4.Text = $player
		$global:result += 4
		$global:pct.Remove(4)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button5_Click = {
		$button5.Enabled = $false
		$button5.Text = $player
		$global:result += 5
		$global:pct.Remove(5)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button6_Click = {
		$button6.Enabled = $false
		$button6.Text = $player
		$global:result += 6
		$global:pct.Remove(6)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	$button7_Click = {
		$button7.Enabled = $false
		$button7.Text = $player
		$global:result += 7
		$global:pct.Remove(7)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button8_Click = {
		$button8.Enabled = $false
		$button8.Text = $player
		$global:result += 8
		$global:pct.Remove(8)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$button9_Click = {
		$button9.Enabled = $false
		$button9.Text = $player
		$global:result += 9
		$global:pct.Remove(9)
		if (global:CheckWin($global:result) -eq $true)
		{
			[System.Windows.Forms.MessageBox]::Show("Вы победили!")
			NewGame
		}
		else
		{
			$global:randpct = $pct | Get-Random
			$buttons[$randpct - 1].Text = $pc
			$buttons[$randpct - 1].Enabled = $false
			$pct.Remove($randpct)
			$global:resultpc += $randpct
			if (global:CheckPcWin($global:resultpc) -eq $true)
			{
				[System.Windows.Forms.MessageBox]::Show("Вы проиграли!")
				NewGame
			}
			elseif ($pct.Count -eq 0)
			{
				[System.Windows.Forms.MessageBox]::Show("Ничья!")
				NewGame
			}
		}
	}
	
	$Form_StateCorrection_Load=
	{
		$formКрестикиНолики.WindowState = $InitialFormWindowState
	}
	
	$Form_Cleanup_FormClosed=
	{
		try
		{
			$button9.remove_Click($button9_Click)
			$buttonO.remove_Click($buttonO_Click)
			$buttonX.remove_Click($buttonX_Click)
			$button8.remove_Click($button8_Click)
			$button7.remove_Click($button7_Click)
			$button6.remove_Click($button6_Click)
			$button5.remove_Click($button5_Click)
			$button4.remove_Click($button4_Click)
			$button3.remove_Click($button3_Click)
			$button2.remove_Click($button2_Click)
			$button1.remove_Click($button1_Click)
			$formКрестикиНолики.remove_Load($formКрестикиНолики_Load)
			$formКрестикиНолики.remove_Load($Form_StateCorrection_Load)
			$formКрестикиНолики.remove_FormClosed($Form_Cleanup_FormClosed)
		}
		catch { Out-Null }
	}

	$formКрестикиНолики.SuspendLayout()
	$formКрестикиНолики.Controls.Add($label2)
	$formКрестикиНолики.Controls.Add($button9)
	$formКрестикиНолики.Controls.Add($buttonO)
	$formКрестикиНолики.Controls.Add($buttonX)
	$formКрестикиНолики.Controls.Add($label1)
	$formКрестикиНолики.Controls.Add($button8)
	$formКрестикиНолики.Controls.Add($button7)
	$formКрестикиНолики.Controls.Add($button6)
	$formКрестикиНолики.Controls.Add($button5)
	$formКрестикиНолики.Controls.Add($button4)
	$formКрестикиНолики.Controls.Add($button3)
	$formКрестикиНолики.Controls.Add($button2)
	$formКрестикиНолики.Controls.Add($button1)
	$formКрестикиНолики.AutoScaleDimensions = '6, 13'
	$formКрестикиНолики.AutoScaleMode = 'Font'
	$formКрестикиНолики.ClientSize = '284, 194'
	$formКрестикиНолики.FormBorderStyle = 'FixedSingle'
	$formКрестикиНолики.Name = 'formКрестикиНолики'
	$formКрестикиНолики.StartPosition = 'CenterScreen'
	$formКрестикиНолики.Text = 'Крестики-Нолики'
	$formКрестикиНолики.add_Load($formКрестикиНолики_Load)
	
	$label2.AutoSize = $True
	$label2.Location = '168, 169'
	$label2.Name = 'label2'
	$label2.Size = '35, 17'
	$label2.TabIndex = 13
	$label2.Text = 'label2'
	$label2.UseCompatibleTextRendering = $True
	
	$button9.Location = '112, 136'
	$button9.Name = 'button9'
	$button9.Size = '50, 50'
	$button9.TabIndex = 12
	$button9.UseCompatibleTextRendering = $True
	$button9.UseVisualStyleBackColor = $True
	$button9.add_Click($button9_Click)
	
	$buttonO.Location = '222, 38'
	$buttonO.Name = 'buttonO'
	$buttonO.Size = '50, 50'
	$buttonO.TabIndex = 11
	$buttonO.Text = 'O'
	$buttonO.UseCompatibleTextRendering = $True
	$buttonO.UseVisualStyleBackColor = $True
	$buttonO.add_Click($buttonO_Click)
	
	$buttonX.Location = '168, 38'
	$buttonX.Name = 'buttonX'
	$buttonX.Size = '50, 50'
	$buttonX.TabIndex = 10
	$buttonX.Text = 'X'
	$buttonX.UseCompatibleTextRendering = $True
	$buttonX.UseVisualStyleBackColor = $True
	$buttonX.add_Click($buttonX_Click)
	
	$label1.AutoSize = $True
	$label1.Location = '168, 22'
	$label1.Name = 'label1'
	$label1.Size = '90, 17'
	$label1.TabIndex = 9
	$label1.Text = 'Выбери Х или О'
	$label1.UseCompatibleTextRendering = $True
	
	$button8.Location = '62, 136'
	$button8.Name = 'button8'
	$button8.Size = '50, 50'
	$button8.TabIndex = 8
	$button8.UseCompatibleTextRendering = $True
	$button8.UseVisualStyleBackColor = $True
	$button8.add_Click($button8_Click)
	
	$button7.Location = '12, 136'
	$button7.Name = 'button7'
	$button7.Size = '50, 50'
	$button7.TabIndex = 7
	$button7.UseCompatibleTextRendering = $True
	$button7.UseVisualStyleBackColor = $True
	$button7.add_Click($button7_Click)
	
	$button6.Location = '112, 87'
	$button6.Name = 'button6'
	$button6.Size = '50, 50'
	$button6.TabIndex = 6
	$button6.UseCompatibleTextRendering = $True
	$button6.UseVisualStyleBackColor = $True
	$button6.add_Click($button6_Click)
	
	$button5.Location = '62, 87'
	$button5.Name = 'button5'
	$button5.Size = '50, 50'
	$button5.TabIndex = 5
	$button5.UseCompatibleTextRendering = $True
	$button5.UseVisualStyleBackColor = $True
	$button5.add_Click($button5_Click)
	
	$button4.Location = '12, 87'
	$button4.Name = 'button4'
	$button4.Size = '50, 50'
	$button4.TabIndex = 4
	$button4.UseCompatibleTextRendering = $True
	$button4.UseVisualStyleBackColor = $True
	$button4.add_Click($button4_Click)
	
	$button3.Location = '112, 38'
	$button3.Name = 'button3'
	$button3.Size = '50, 50'
	$button3.TabIndex = 3
	$button3.UseCompatibleTextRendering = $True
	$button3.UseVisualStyleBackColor = $True
	$button3.add_Click($button3_Click)
	
	$button2.Location = '62, 38'
	$button2.Name = 'button2'
	$button2.Size = '50, 50'
	$button2.TabIndex = 1
	$button2.UseCompatibleTextRendering = $True
	$button2.UseVisualStyleBackColor = $True
	$button2.add_Click($button2_Click)
	
	$button1.Location = '12, 38'
	$button1.Name = 'button1'
	$button1.Size = '50, 50'
	$button1.TabIndex = 0
	$button1.UseCompatibleTextRendering = $True
	$button1.UseVisualStyleBackColor = $True
	$button1.add_Click($button1_Click)
	$formКрестикиНолики.ResumeLayout()
	
	$InitialFormWindowState = $formКрестикиНолики.WindowState
	
	$formКрестикиНолики.add_Load($Form_StateCorrection_Load)
	
	$formКрестикиНолики.add_FormClosed($Form_Cleanup_FormClosed)
	
	return $formКрестикиНолики.ShowDialog()