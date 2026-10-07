# G 1/2" to Hose Barb Adapter

A heavy-duty, 3D-printable adapter connecting a standard G 1/2" shower hose to a flexible aquarium or garden hose.
Written in OpenSCAD, this parametric model features an ergonomic cross handle (faucet knob) for easy, tool-free tightening and reinforced walls for secure clamping.

## 📷 Gallery

<p align="center">
  <img src="https://github.com/user-attachments/assets/7030083c-0ead-4226-9a18-7266c420a5d3" height="250" alt="OpenSCAD Render" />
  <img src="https://github.com/user-attachments/assets/ac728592-f4fe-4934-a048-81ec9e81e212" height="250" alt="Top View" />
  <img src="https://github.com/user-attachments/assets/76f716e1-ab44-4eb6-bd99-48b51e16c518" height="250" alt="Side Profile" />
  <img src="https://github.com/user-attachments/assets/e27f68fd-4c2c-4fba-ba3c-27b35c408714" height="250" alt="Assembled System" />
</p>

* **OpenSCAD Render:** 3D visualization of the generated parametric model.
* **Top View:** Printed adapter standing vertically, showcasing the thick-walled internal bore and robust cross handle.
* **Side Profile:** Central hub, hose barb teeth, and the G 1/2" thread base.
* **Assembled System:** The adapter screwed into a metal shower hose fitting and secured to a flexible hose worm-drive clamp.

## 📏 Default Dimensions

Based on the default parameters in the OpenSCAD file, the generated adapter has the following specifications:
* **Shower Thread:** G 1/2" (BSPP)
* **Hose Barb:** Designed for a 12.5 mm (1/2") inner diameter hose
* **Internal Bore:** 7.5 mm (Ensures thick, heavy-duty walls)
* **Handle Type:** 4-spoke cross knob (26 mm hub, ~58 mm total span)

## ✨ Features

* **Fully Parametric:** Easily adjust hose diameter, thread clearance, and wall thickness directly in the OpenSCAD file to fit your specific setup.
* **Heavy-Duty Walls:** The internal bore is narrowed to create a thick, pressure-resistant structure. It will not crack or crush under the heavy tension of a metal worm-drive hose clamp.
  
## 🖨️ Recommended Print Settings

To ensure the adapter is watertight and withstands mains water pressure without delaminating, follow these guidelines:
* **Material:** PETG or PETG-CF (Carbon Fiber) works best for layer adhesion and impact resistance. Do not use TPU (too soft for threads) or standard PLA (too brittle).
* **Layer Height:** 0.12 mm - 0.16 mm. A low layer height is MANDATORY to accurately resolve the fine pitch of the G 1/2" thread.
* **Walls/Perimeters:** 3-4 walls (for watertightness and structural strength).
* **Top/Bottom Thickness:** 1.2 mm - 1.6 mm.
* **Z-Seam:** 'Aligned' or 'Sharpest Corner'. Do NOT use 'Random', as scattered seam bumps on the threads will prevent the shower gasket from sealing properly.

## ⚠️ Note on Material Shrinkage & Assembly

FDM plastics tend to shrink slightly after printing and cooling down. To compensate for this and ensure a perfect fit:
* The OpenSCAD script independently scales down the thread by 1% (`thread_scale = 0.99`) for a smooth fit into the shower hose nut.
* The script scales up the hose barb by 1% (`barb_scale = 1.01`) to guarantee a tight, watertight seal against the flexible hose.

> **Pro-Tip for Assembly:** Before sliding your hose onto the printed barb, dip the end of the hose in boiling water for 30 seconds. The heat will soften the rubber/PVC, allowing it to glide over the scaled-up teeth easily. Once it cools, it will shrink-fit tightly around the printed part. Secure it with a metal hose clamp for a permanent, leak-proof connection.

---
*This project is open-source and provided strictly for personal, educational, and non-commercial purposes. You are free to explore, modify, and learn from the codebase. If you wish to use this project for commercial purposes, please contact me. Developed and designed by Maciej Ślubowski.
