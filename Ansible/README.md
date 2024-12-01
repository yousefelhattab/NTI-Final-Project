
---

# Jenkins Setup with Ansible

This Ansible playbook automates the installation and configuration of **Jenkins** on an EC2 instance, including dependencies, plugins, and service setup.

### Setup Instructions

1. **Modify the `inventory.ini` file**:
   Update the EC2 instance’s public IP and path to your private key.

   Example `inventory.ini`:
   ```ini
   [jenkins_server]
   ec2-jenkins ansible_host=<JENKINS_EC2_PUBLIC_IP> ansible_user=ec2 ansible_ssh_private_key_file=/path/to/private-key.pem
   ```

2. **Run the Playbook**:
   Execute the playbook to set up Jenkins:

   ```bash
   ansible-playbook -i inventory.ini playbook_setup_jenkins.yml
   ```

3. **Customization**:
   - Modify the **`jenkins_plugins`** list to add/remove plugins.
   - Edit **`jenkins_config.xml`** to customize Jenkins settings.

4. **Troubleshooting**:
   - **SSH Key Issues**: Ensure the private key is correct and has proper permissions (`chmod 400 key.pem`).
   - **Service Issues**: Check Jenkins logs at `/var/log/jenkins/jenkins.log`.

This playbook installs Jenkins, required dependencies, configures plugins, and ensures the Jenkins service is running.

---
