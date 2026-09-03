# Bus Traffic Fever - Unsigned IPA

This project builds an **unsigned iOS IPA** specifically so it can be signed later with an external signing tool such as eSign.

## GitHub Actions

1. Upload this project to the repository.
2. Open **Actions**.
3. Run **Build Bus Traffic Fever - Unsigned IPA**.
4. When the workflow is green, open the completed run.
5. Under **Artifacts**, download:
   `BusTrafficFever-unsigned-IPA`
6. The ZIP artifact contains:
   `BusTrafficFever-unsigned.ipa`

The IPA is intentionally unsigned. Do not add Apple certificates or provisioning profiles to the workflow.

## eSign

Import `BusTrafficFever-unsigned.ipa` into your own eSign/signing workflow and sign it with your own certificate/profile.

## Important

An unsigned IPA is not directly installable on iPhone. It must be signed with a valid certificate/provisioning setup before installation.
