/*
  Plumbing Connector: Shower Hose (G 1/2" Thread) -> Garden/Aquarium Hose
  Version: Cross handle (faucet style), custom scaling factors, and reinforced heavy-duty walls.
*/

// --- CONFIGURATION VARIABLES ---
hose_inner_diam = 12.5;     // Inner diameter of your flexible hose (mm)
thread_clearance = 0.15;    // Thread tolerance (mm) to compensate for FDM material shrinkage
$fn = 100;                  // High resolution for smooth arcs and cylinders

// --- MATERIAL SCALING FACTORS ---
thread_scale = 0.99;        // Scale down the thread by 1% for a perfect fit
barb_scale = 1.01;          // Scale up the hose barb by 1% for a tighter water seal

// --- INTERNAL PARAMETERS (Calculated) ---
// G 1/2" Thread (BSPP) - Scaled down
thread_od = (20.95 * thread_scale) - thread_clearance;
thread_pitch = 1.814 * thread_scale;
thread_length = 12;

// Cross Handle (Faucet Knob) - Replaces standard hex nut for better manual leverage
handle_hub_diam = 26;       // Diameter of the central solid hub
handle_height = 10;         // Z-height (thickness) of the handle for a comfortable grip
handle_spoke_len = 20;      // Length of the spokes extending from the hub

// Hose Barb - Scaled up
barb_length_total = 30;
barb_teeth_count = 3;
barb_tooth_height = 5;
barb_max_diam = (hose_inner_diam + 1.5) * barb_scale;
barb_min_diam = hose_inner_diam * barb_scale;
smooth_shank_len = 15;
smooth_shank_diam = (hose_inner_diam + 0.5) * barb_scale;

// Internal Bore (Through-hole)
// Wall thickening: reducing bore diameter by 5 mm creates heavy-duty, pressure-resistant walls
bore_diam = hose_inner_diam - 5; 

// --- MAIN MODULE ASSEMBLY ---
difference() {
    union() {
        // 1. G 1/2" Thread (Top Section)
        translate([0, 0, barb_length_total + handle_height])
            simple_thread(od=thread_od, pitch=thread_pitch, length=thread_length);

        // 2. Cross Handle (Middle Section)
        translate([0, 0, barb_length_total])
            cross_handle(hub_diam=handle_hub_diam, height=handle_height, spoke_length=handle_spoke_len);

        // 3. Hose Barb (Bottom Section)
            build_barb();
    }

    // 4. Continuous Internal Bore (subtracting the through-hole)
    translate([0, 0, -1])
        cylinder(h = barb_length_total + handle_height + thread_length + 2, d = bore_diam);
}

// --- HELPER MODULES ---

module cross_handle(hub_diam, height, spoke_length) {
    spoke_tip_diam = 14;   // Rounded tip diameter (ergonomic for wet hands)
    spoke_base_width = 16; // Wide spoke base to prevent snapping under torque
    
    union() {
        // Central hub
        cylinder(h=height, d=hub_diam);
        
        // 4 extending spokes (cross pattern)
        for(i=[0:90:270]) {
            rotate([0, 0, i]) {
                hull() {
                    // Base firmly merged into the central hub
                    translate([hub_diam/2 - 2, -spoke_base_width/2, 0])
                        cube([2, spoke_base_width, height]);
                    
                    // Rounded tip placed at the designated spoke length
                    translate([hub_diam/2 + spoke_length - spoke_tip_diam/2, 0, 0])
                        cylinder(h=height, d=spoke_tip_diam);
                }
            }
        }
    }
}

module build_barb() {
    // Barb teeth (stacking upwards)
    for(i = [0 : barb_teeth_count - 1]) {
        translate([0, 0, i * barb_tooth_height])
            cylinder(h=barb_tooth_height, d1=barb_min_diam, d2=barb_max_diam);
    }
    
    // Smooth shank area specifically designed for a metal hose clamp
    translate([0, 0, barb_teeth_count * barb_tooth_height])
        cylinder(h=smooth_shank_len, d=smooth_shank_diam);
}

module simple_thread(od, pitch, length) {
    r = od/2;
    // Thread profile optimized for 3D printing overhangs and structural stability
    r_core = r - (0.866 * pitch * 0.625);
    res = $fn > 0 ? $fn : 60;
    z_step = pitch/res;
    a_step = 360/res;
    num_steps = ceil((length/pitch) * res);

    intersection() {
        // Outer bounding cylinder to cut off excess thread ends flat (ensures proper gasket seal)
        cylinder(h=length, r=r, $fn=res); 
        union() {
            // Core cylinder with a slight overlap to guarantee manifold geometry
            cylinder(h=length, r=r_core + 0.05, $fn=res);
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
    polygon([ [-0.1, -pitch/2], [r-r_core, 0], [-0.1, pitch/2] ]);
}