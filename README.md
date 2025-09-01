# Welcome to HomelabNotes  DevOps & Cloud Lab

A public repository documenting my journey of building a powerful, automated, and cloud-native inspired homelab. As a professional Hybrid Cloud System Engineer, this is my space to learn, experiment, and share knowledge with the community.

![GitHub last commit](https://img.shields.io/github/last-commit/homelabnotes/homelab-infra)
![GitHub repo size](https://img.shields.io/github/repo-size/homelabnotes/homelab-infra)
![GitHub stars](https://img.shields.io/github/stars/homelabnotes/homelab-infra?style=social)

---

## 🎯 Core Philosophy

The goal of **HomelabNotes** is twofold:
1.  **Deepen My Own Skills:** To have a hands-on environment to master Infrastructure-as-Code (IaC), container orchestration, and automation tools that are critical in the world of hybrid cloud.
2.  **Help the Community:** To create clear, actionable tutorials and documentation for others who are navigating similar challenges. If you're looking to learn **Terraform, Kubernetes, Ansible, or Vault** in a practical setting, you're in the right place.

This lab is all about applying enterprise-grade concepts to a home environment.

---

## 🏗️ The Hardware Stack

My setup is designed to be powerful, compact, and efficient. Here's the current hardware foundation.

| Component         | Brand & Model                               | Specs                                     | Purpose                                    |
| ----------------- | ------------------------------------------- | ----------------------------------------- | ------------------------------------------ |
| **Router** | `MikroTik RB5009UG+S+IN`                    | `Marvell Armada 1.4 GHz Quad-Core`        | `Core routing, firewall, and networking`   |
| **Hypervisor** | `Custom Mini PC`                            | `Ryzen 7 5825U, 64GB RAM, 512GB NVMe`     | `Main Proxmox host for VMs & containers`   |
| **Utility Node** | `Raspberry Pi 4B`                           | `8GB RAM`                                 | `Runs lightweight Docker services (Pi-hole)` |

### Future Upgrades
I'm always planning the next step. Here's what's on the wishlist:
-   **Switch:** `MikroTik CRS310-8G+2S+IN` for 10GbE networking.
-   **NAS:** A custom-built TrueNAS system for centralized and resilient storage.

---

## 💻 The Software & Technologies

This is where the real fun begins. My stack is built with modern, cloud-native principles in mind.

-   **Virtualization:** **Proxmox VE** for robust VM and LXC management.
-   **Networking:** **MikroTik RouterOS** and **Pi-hole** for DNS-level ad blocking.
-   **Infrastructure as Code:** **Terraform** to define and manage my network and infrastructure declaratively.
-   **Automation:** **Ansible** for configuration management and application deployment.
-   **Secrets Management:** **HashiCorp Vault** for securely storing credentials and secrets.
-   **Containerization:** **Docker** for now, with a clear path towards learning and implementing **Kubernetes (k3s/k8s)**.

---

## 🤝 Contributing

Feedback, suggestions, and contributions are highly welcome! If you spot an error or have an idea for a tutorial, please open an issue or submit a pull request.

---

## 📫 Let's Connect

-   **Website:** Coming Soon -   **GitHub:** [HomelabNotes](https://github.com/homelabnotes) -   **LinkedIn:** [David Woitzik](https://www.linkedin.com/in/david-woitzik-94b323268/)
