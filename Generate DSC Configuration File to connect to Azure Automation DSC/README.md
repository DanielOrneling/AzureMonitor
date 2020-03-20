# Generate DSC Configuration File to connect to Azure Automation DSC
Use this script to generate the configuration files needed to connect to Azure Automation DSC.

In the script below, just add your values at lines 93 and 94. At line 95, you can add your server name(s) instead of the ones I´ve used. Running the script will create a MOF file for every server you added in a folder called “DscMetaConfigs” in the folder you´re standing with the PowerShell window.

If you really want to force your way onto a server, you could use ApplyAndAutoCorrect instead. Beware though that this can be real risky to use in a production environment since all the changes you make that don´t go along with the configuration will be wiped away. In other words, don´t use this configuration mode without having thought it through first.

ApplyOnly:
DSC applies the configuration and does nothing further unless a new configuration is pushed to the target node or when a new configuration is pulled from a server. After initial application of a new configuration, DSC does not check for drift from a previously configured state. Note that DSC will attempt to apply the configuration until it is successful before ApplyOnly takes effect.

ApplyAndMonitor:
This is the default value. The LCM applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs. Note that DSC will attempt to apply the configuration until it is successful before ApplyAndMonitor takes effect.

ApplyAndAutoCorrect:
DSC applies any new configurations. After initial application of a new configuration, if the target node drifts from the desired state, DSC reports the discrepancy in logs, and then re-applies the current configuration.
With this script the configuration will be checked within the server every 15 minutes, and the server will check with Azure Automation for new configuration rules every 30 minutes.

Run the script below with the changes I´ve pointed out above and you have the first step cleared.
