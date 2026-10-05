# G 1/2" to Hose Barb Adapter

A heavy-duty, 3D-printable adapter connecting a standard G 1/2" shower hose to a flexible aquarium or garden hose.
Written in OpenSCAD, this parametric model features an ergonomic cross handle (faucet knob) for easy, tool-free tightening and reinforced walls for secure clamping.

## 📷 Gallery

![OpenSCAD 3D Render](0.png)
* **0.png:** 3D render of the parametric model generated in OpenSCAD.

![Top view of printed adapter](1.jpg)
* **1.jpg:** Printed adapter standing vertically, showcasing the thick-walled internal bore and robust cross handle.

![Side profile of printed adapter](2.jpg)
* **2.jpg:** Side profile displaying the central hub, hose barb teeth, and the G 1/2" thread base.

![Adapter assembled with hoses](3.jpg)
* **3.jpg:** Fully assembled system in action—the adapter is screwed into a metal shower hose fitting and secured to a flexible hose with a metal worm-drive clamp.

## 📏 Default Dimensions

Based on the default parameters in the OpenSCAD file, the generated adapter has the following specifications:
* **Shower Thread:** G 1/2" (BSPP)
* **Hose Barb:** Designed for a 12.5 mm (1/2") inner diameter hose
* **Internal Bore:** 7.5 mm (Ensures thick, heavy-duty walls)
* **Handle Type:** 4-spoke cross knob (26 mm hub, ~58 mm total span)

## ✨ Features

* **Fully Parametric:** Easily adjust hose diameter, thread clearance, and wall thickness directly in the OpenSCAD file to fit your specific setup.
* **Heavy-Duty Walls:** The internal bore is narrowed to create a thick, pressure-resistant structure. It will not crack or crush under the heavy tension of a metal worm-drive hose clamp.
* **Support-Free Design:** By orienting the thread flat on the build plate, the handle chamfers and barb teeth print perfectly without any supports.

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
*This project is open-source and provided strictly for personal, educational, and non-commercial purposes. You are free to explore, modify, and learn from the codebase. If you wish to use this project for commercial purposes, please contact me. Źródło: Opracowane i zaprojektowane przez Macieja Ślubowskiego.*
