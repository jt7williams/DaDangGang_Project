using UnityEngine;

public class target : MonoBehaviour
{
    public float health = 10f;
	public GameObject flesh;
	public GameObject dependency;
	public GameObject collider;
	//public GameObject zombie;
	public GameObject removable;
	
	public GameObject splat;
	
	int isalive = 1;
    public void damageTake(float amt){
		if (dependency == null) 
		{
			if (isalive == 1)
			{
				health -= amt;
				if(health <= 0f){
					dead();
				}
			}
		}
    }

    void dead(){
		
		GameObject blood = Instantiate(splat);
		//splat.transform.localPosition = meatFlap.transform.position;
		//splat.transform.position = new Vector3(0, 0, 0);
		splat.transform.SetParent(flesh.transform, false);
		
		
        GameObject meatFlap = Instantiate(flesh);
		meatFlap.transform.localPosition =  collider.transform.position; //gameObject.transform.position;
		
		Destroy(removable);
		isalive = 0;
		//if (collider.GetComponent<Collider>() != null)
		{
			Destroy(collider.GetComponent<Collider>());
		}
		Destroy(meatFlap, 6.0f);
    }
}