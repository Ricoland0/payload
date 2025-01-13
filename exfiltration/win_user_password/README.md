# Windows-User-Hash-Password-Exfiltration

## Description
This script uses **Mimikatz** to extract Windows user password hashes and exfiltrate them via a **Discord webhook**. It automates the entire process of downloading Mimikatz, running it to dump password hashes, and sending them to a Discord channel for further analysis.

The script is designed for **ethical hacking** and **penetration testing** purposes. It can be run on **Windows systems**. Ensure you have permission to run this script on any target machine.

### Planned Optimizations:
- **Speed improvements**: Reducing unnecessary delays and optimizing download and extraction processes for Mimikatz.
- **Security enhancements**: Ensuring **no trace** is left on the target machine, including hiding the script’s execution and minimizing logs.
- **Automated password cracking**: After hash extraction, the script will automatically attempt to crack the hash to recover the plaintext password.

## Requirements:
- **Internet access** to download Mimikatz from the official GitHub repository.
- **Discord webhook** (you need to set your own webhook URL).

## Bonus
This script works with **RubberDucky** and **FlipperZero** or other badUSB

### Webhook Configuration:
Make sure to update the **Discord webhook URL** in the script before running:

```powershell
$webhookUrl = "<your_webhook_url>"
