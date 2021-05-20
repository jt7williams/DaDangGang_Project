using UnityEngine;

public class WeaponSwitching : MonoBehaviour
{

    public int selectedWeapon = 0;
    //public float switchDelay = 0.5f;
    //private float nextSwitch;

    // Start is called before the first frame update
    void Start()
    {
        SelectWeapon();
    }

    // Update is called once per frame
    void Update()
    {

        int prevSelWep = selectedWeapon;

        if (Input.GetAxis("Mouse ScrollWheel") > 0f){
            if(selectedWeapon >= transform.childCount - 1)
                selectedWeapon = 0;
            else
                selectedWeapon++;
        }
        if (Input.GetAxis("Mouse ScrollWheel") < 0f){
            if(selectedWeapon <= 0)
                selectedWeapon = transform.childCount - 1;
            else
                selectedWeapon--;
        }

        if(Input.GetKeyDown(KeyCode.Alpha1)){
            selectedWeapon = 0;
        }

        if(Input.GetKeyDown(KeyCode.Alpha2)){
            selectedWeapon = 1;
        }

        if(Input.GetKeyDown(KeyCode.Alpha3)){
            selectedWeapon = 2;
        }

        if (prevSelWep != selectedWeapon){
            //nextSwitch = Time.time + switchDelay;
            SelectWeapon();
        }
    }

    public void SelectWeapon(){
        int i = 0;
        foreach (Transform weapon in transform){
            if (i == selectedWeapon)
                weapon.gameObject.SetActive(true);
            else
                weapon.gameObject.SetActive(false);
            i++;
        }
    }
}
