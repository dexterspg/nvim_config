import java.util.LinkedList;

interface  User{
   void f1(); 
  

}

/**
 * @param hello
 */
class Gamer implements  User{

	int id;
	
	public Gamer() {
	}

	@Override
	public void f1() {
		// TODO Auto-generated method stub
		
	}
	
	public void f2(){}
	
}

public class Demo{

	public void main(String [] args){

     	//new ArrayList<String>();
		Gamer game = new Gamer();
        		
		game.f1();
	
	}


}
