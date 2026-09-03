# Bus Traffic Fever

A from-scratch SwiftUI prototype inspired by the supplied Bus Traffic Fever screenshots.

## Included
- Portrait iOS app
- Loading screen
- Home screen
- Hard Level 8 screen
- Bus sorting gameplay
- Colored buses and passenger track
- Power-up buttons
- GitHub Actions workflow that builds an unsigned IPA

## GitHub build
1. Create a new GitHub repository.
2. Upload all files from this project.
3. Push to `main`.
4. Open **Actions → Build Bus Traffic Fever IPA**.
5. Download the `BusTrafficFever-IPA` artifact.

### Important
The workflow creates an **unsigned IPA**. iOS requires code signing for installation on a real device. You can sign the app with your Apple Developer certificate/profile or a sideloading/signing service before installing.

No external packages or npm/node are required.
