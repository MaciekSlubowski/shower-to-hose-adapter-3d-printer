/*
  Plumbing Connector: Shower Hose (G 1/2" Thread) -> Garden/Aquarium Hose
  Version: Heavy-Duty Reinforced — thicker walls, anti-snap stress-relief cones 
  around the 4-spoke cross knob, and enlarged hose barbs + worm-drive clamp ribs.
*/

// --- CONFIGURATION VARIABLES ---
hose_inner_diam = 12.5;     // Inner diameter of your flexible hose (mm)
thread_clearance = 0.15;    // Thread tolerance (mm) to compensate for FDM material shrinkage
$fn = 100;                  // High resolution for smooth arcs and cylinders

// --- MATERIAL SCALING FACTORS ---
thread_scale = 0.99;        // Scale down the thread by 1% for a perfect fit
barb_scale = 1.01;          // Scale up the hose barb by 1% for a tighter water seal

// --- INTERNAL PARAMETERS (Calculated) ---
// G 1/2" Thread (BSPP) - Scaled down, slightly longer to accommodate base reinforcement
thread_od = (20.95 * thread_scale) - thread_clearance;
thread_pitch = 1.814 * thread_scale;
thread_length = 14;         // Increased from 12 to 14 mm to allow a 2 mm stress-relief collar
thread_collar_height = 2.0; // Conical reinforcement at the thread root (prevents snapping)

// Cross Handle (Faucet Knob) - Reinforced hub and height
handle_hub_diam = 28;       // Increased from 26 to 28 mm for a stronger core
handle_height = 12;         // Increased from 10 to 12 mm for higher torque resistance
handle_spoke_len = 20;      // Length of the spokes extending from the hub

// Hose Barb & Worm-Drive Clamp Section - Scaled up & thickened
barb_length_total = 32;     // Slightly longer to fit the anti-snap cone under the knob
barb_teeth_count = 3;
barb_tooth_height = 5;
barb_tooth_flat = 0.8;      // Flat crest on each tooth so tips don't print brittle

// Enlarged barbs for stronger grip and thicker walls:
barb_min_diam = (hose_inner_diam + 0.8) * barb_scale; // Thicker root (+0.8 mm vs +0.0 mm)
barb_max_diam = (hose_inner_diam + 2.2) * barb_scale; // Larger barb protrusion (+2.2 mm vs +1.5 mm)

// Worm-drive clamp zone (upper shank) with retention ribs:
smooth_shank_len = 17;
smooth_shank_diam = (hose_inner_diam + 1.2) * barb_scale; // Thicker wall under clamp
clamp_rib_diam = (hose_inner_diam + 1.9) * barb_scale;    // Slightly raised ribs for worm-drive clamp
shank_fillet_height = 5.5;  // Conical reinforcement where the shank meets the 4-spoke knob

// Internal Bore (Through-hole)
// Reduced bore diameter (from -5 to -6.5 mm) for heavy-duty walls across the entire part
bore_diam = hose_inner_diam - 6.5; // 6.0 mm bore -> ~3.7-6.4 mm solid walls everywhere

// --- MAIN MODULE ASSEMBLY ---
difference() {
    union() {
        // 1. G 1/2" Thread (Top Section) with overlap into the handle
        translate([0, 0, barb_length_total + handle_height - 0.5])
            simple_thread(od=thread_od, pitch=thread_pitch, length=thread_length + 0.5);

        // 1b. Stress-relief conical collar at the base of the G 1/2" thread
        translate([0, 0, barb_length_total + handle_height - 0.2])
            cylinder(h=thread_collar_height + 0.2, d1=thread_od + 2.8, d2=thread_od - 0.4);

        // 2. Cross Handle (Middle Section)
        translate([0, 0, barb_length_total])
            cross_handle(hub_diam=handle_hub_diam, height=handle_height, spoke_length=handle_spoke_len);

        // 3. Hose Barb + Worm-Drive Clamp Ribs + Anti-Snap Cone (Bottom Section)
        build_barb();
    }

    // 4. Continuous Internal Bore (subtracting the through-hole)
    translate([0, 0, -1])
        cylinder(h = barb_length_total + handle_height + thread_length + 2, d = bore_diam);

    // 5. Smooth conical lead-in at both ends of the bore (reduces turbulence & stress)
    translate([0, 0, -0.1])
        cylinder(h = 2.0, d1 = bore_diam + 2.0, d2 = bore_diam);
    translate([0, 0, barb_length_total + handle_height + thread_length - 1.9])
        cylinder(h = 2.0, d1 = bore_diam, d2 = bore_diam + 2.0);
}

// --- HELPER MODULES ---

module cross_handle(hub_diam, height, spoke_length) {
    spoke_tip_diam = 14;   // Rounded tip diameter (ergonomic for wet hands)
    spoke_base_width = 18; // Widened from 16 to 18 mm to prevent snapping under torque
    
    union() {
        // Central hub
        cylinder(h=height, d=hub_diam);
        
        // 4 extending spokes (cross pattern)
        for(i=[0:90:270]) {
            rotate([0, 0, i]) {
                hull() {
                    // Base firmly merged deeper into the central hub
                    translate([hub_diam/2 - 3, -spoke_base_width/2, 0])
                        cube([3, spoke_base_width, height]);
                    
                    // Rounded tip placed at the designated spoke length
                    translate([hub_diam/2 + spoke_length - spoke_tip_diam/2, 0, 0])
                        cylinder(h=height, d=spoke_tip_diam);
                }
            }
        }
    }
}

module build_barb() {
    union() {
        // 1. Enlarged Barb Teeth (stacking upwards with non-brittle flat crests)
        for(i = [0 : barb_teeth_count - 1]) {
            translate([0, 0, i * barb_tooth_height]) {
                // Sloped cone of the tooth
                cylinder(
                    h = barb_tooth_height - barb_tooth_flat + 0.1,
                    d1 = (i == 0) ? barb_min_diam - 0.6 : barb_min_diam,
                    d2 = barb_max_diam
                );
                // Short flat land at the crest of the tooth so it doesn't shear off
                translate([0, 0, barb_tooth_height - barb_tooth_flat])
                    cylinder(h = barb_tooth_flat + 0.2, d1 = barb_max_diam, d2 = barb_max_diam - 0.3);
            }
        }
        
        // 2. Reinforced Shank Area for the Metal Worm-Drive Clamp
        shank_start_z = barb_teeth_count * barb_tooth_height;
        translate([0, 0, shank_start_z - 0.2])
            cylinder(h = smooth_shank_len + 0.7, d = smooth_shank_diam);

        // 3. Two Enlarged Retention Ribs specifically in the Worm-Drive Clamp Zone
        // Prevents the hose from slipping out under pressure when clamped
        for(rib_z = [shank_start_z + 2.5, shank_start_z + 7.5]) {
            translate([0, 0, rib_z]) {
                cylinder(h = 1.6, d1 = smooth_shank_diam, d2 = clamp_rib_diam);
                translate([0, 0, 1.6])
                    cylinder(h = 0.8, d = clamp_rib_diam);
                translate([0, 0, 2.4])
                    cylinder(h = 1.2, d1 = clamp_rib_diam, d2 = smooth_shank_diam);
            }
        }

        // 4. Heavy-Duty Anti-Snap Cone (Transition into the 4-spoke Cross Handle)
        // Eliminates the 90-degree fracture point right below the knob
        translate([0, 0, barb_length_total - shank_fillet_height])
            cylinder(
                h = shank_fillet_height + 0.5,
                d1 = smooth_shank_diam,
                d2 = handle_hub_diam - 3
            );
    }
}

module simple_thread(od, pitch, length) {
    r = od/2;
    // Slightly shallower root factor (0.58 instead of 0.625) for a thicker thread core wall
    r_core = r - (0.866 * pitch * 0.58);
    res = $fn > 0 ? $fn : 60;
    z_step = pitch/res;
    a_step = 360/res;
    num_steps = ceil((length/pitch) * res);

    intersection() {
        // Outer bounding cylinder to cut off excess thread ends flat (ensures proper gasket seal)
        cylinder(h=length, r=r, $fn=res); 
        union() {
            // Core cylinder with overlap to guarantee manifold geometry
            cylinder(h=length, r=r_core + 0.08, $fn=res);
            // Spiral generation via hulling 2D profiles
            for(i=[0:num_steps-1]) {
                hull() {
                    _thread_profile(r, r_core, pitch, i*a_step, i*z_step);
                    _thread_profile(r, r_core, pitch, (i+1)*a_step, (i+1)*z_step);
                }
            }
        }
    }
}

module _thread_profile(r, r_core, pitch, a, z) {
    rotate([0, 0, a])
    translate([r_core, 0, z])
    rotate([90, 0, 0])
    // Flat 2D cross-section extruded and hulled to form the 3D spiral
    linear_extrude(0.01, center=true)
    polygon([ [-0.15, -pitch/2], [r-r_core, 0], [-0.15, pitch/2] ]);
}