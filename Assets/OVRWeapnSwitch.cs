using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class OVRWeapnSwitch : MonoBehaviour
{
    // Start is called before the first frame update
    public GameObject _m4;
    public GameObject _Skorpion;
    public GameObject _ak;
    public OVRInput.Button WeaponSwitchButton;
    public GameObject LHandProp;
    public GameObject Lhand;
    int iterate = 0;
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        if (OVRInput.GetDown(WeaponSwitchButton))
        {
            iterate++;
            switch (iterate)
            {
                case 0:
                    //do Nothing here

                    break;
                case 1:
                    //Code for switching to the M4 WEAPON!
                    LHandProp.GetComponent<Collider>().enabled = true;
                    LHandProp.transform.localPosition = new Vector3(0.025f, -0.02f, 0.51f);
                    LHandProp.transform.localRotation = Quaternion.Euler(new Vector3(-18.943f, -27.731f, -86.269f));
                    _m4.SetActive(true);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(false);
                    break;
                case 2:
                    //Code for swithcing to the SKORPTION WEAPON
                    LHandProp.GetComponent<Collider>().enabled = false;
                    LHandProp.transform.GetChild(0).GetChild(0).gameObject.SetActive(false);
                    Lhand.SetActive(true);
                    _m4.SetActive(false);
                    _Skorpion.SetActive(true);
                    _ak.SetActive(false);
                    break;
                case 3:
                    //Code for switching to AK WEAPON
                    LHandProp.GetComponent<Collider>().enabled = true;
                    LHandProp.transform.localPosition = new Vector3(0.081f, -0.006f, 0.554f);
                    LHandProp.transform.localRotation = Quaternion.Euler(new Vector3(-18.943f, -16.098f, -86.269f));
                    _m4.SetActive(false);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(true);
                    break;

                default:
                    iterate = 0;
                    LHandProp.GetComponent<Collider>().enabled = false;
                    LHandProp.transform.GetChild(0).GetChild(0).gameObject.SetActive(false);
                    Lhand.SetActive(true);
                    _m4.SetActive(false);
                    _Skorpion.SetActive(false);
                    _ak.SetActive(false);
                    break;
            }
        }
        
    }
}
