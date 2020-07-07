function metal1(dataDir)

global bv;

atoms={
    'Li' 'Li_sv'    1.56
    'Be' 'Be'       1.13 
    'Na' 'Na_pv'    1.91
    'Mg' 'Mg'       1.60
    'Al' 'Al'       1.43
    'K'  'K_sv'     2.38
    'Ca' 'Ca_pv'    1.98
    'Sc' 'Sc_sv'    1.64
    'Ti' 'Ti_pv'    1.46
    'V'  'V_pv'     1.35
    'Cr' 'Cr_pv'    1.28
    'Mn' 'Mn'       1.26
    'Fe' 'Fe'       1.27
    'Co' 'Co'       1.25
    'Ni' 'Ni'       1.25
    'Cu' 'Cu'       1.35
    'Zn' 'Zn'       1.31
    'Ga' 'Ga_d'     1.41
    'Ge' 'Ge_d'     1.37
    'Rb' 'Rb_sv'    2.55
    'Sr' 'Sr_sv'    2.15
    'Y'  'Y_sv '    1.80
    'Zr' 'Zr_sv'    1.60
    'Nb' 'Nb_pv'    1.47
    'Mo' 'Mo_pv'    1.40
    'Tc' 'Tc_pv'    1.36
    'Ru' 'Ru'       1.34
    'Rh' 'Rh'       1.35
    'Pd' 'Pd'       1.38
    'Ag' 'Ag'       1.52
    'Cd' 'Cd'       1.48
    'In' 'In_d'     1.66
    'Sn' 'Sn_d'     1.55
    'Sb' 'Sb'       1.59
    'Cs' 'Cs_sv'    2.73
    'Ba' 'Ba_sv'    2.24
    'Tl' 'Tl_d'     1.72
    'Pb' 'Pb_d'     1.75
    'Bi' 'Bi_d'     1.70
    'Po' 'Po'       1.76
    'Fr' 'Fr_sv'    1.75
    'Ra' 'Ra_sv'    1.37
    'Pt' 'Pt'       1.39
    'Au' 'Au'       1.44 
 };

b=12;
bv=eye(3)*b;

cd('Data');
mkdir(dataDir);
cd(dataDir);

 for i=1:size(atoms,1)
    saveFile(atoms{i,1});
 end
 
 cd ../..
  
end

function saveFile(atom)
     
     global bv;
     
     fid = fopen(atom,'w');

     atoms = {atom};
     num = 1;
     posHead(fid,atoms,num,bv);

     fprintf(fid,'0.5\t0.5\t0.5\tT\tT\tT\n');

     fclose(fid);

end