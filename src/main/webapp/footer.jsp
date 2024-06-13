<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<style>
  #footer{
    padding: 1ch 16ch;
    background: var(--secondary-color-1);
    display: flex;
    width: 100%;
    justify-content: space-between;
    align-items: center;
    flex-direction: row;
  }

  #footer p{
    margin: 0;
  }

  .brand-text{
    text-align: end;
    font-weight: bold;
    font-size: 1.1rem;
    color: var(--red-color-2);
  }

  .brand-color{
    color: var(--orange-color-1)
  }

  .footer-italic{
    font-style: italic;
    font-weight: normal;
    font-size: 0.9rem;
    color: var(--primary-color-2);
  }

  .brand-copyright{
    font-size: 0.9rem;
    text-align: center;
  }

  .brand-icon{
    height: 40px;
    cursor: pointer;
  }

  .brand-icons{
      display: flex;
      flex-direction: row;
      align-items: center;
      gap: 16px;
  }

  @media screen and (max-width: 1140px){
    #footer {
      padding: 1ch 2ch;
    }
  }

  @media screen and (max-width: 740px){
    #footer {
      flex-direction: column;
      gap: 4px;
    }

    .brand-text{
      font-size: 1rem;
      text-align: center;
    }

    .footer-italic{
      font-size: 0.8rem;
    }

    .brand-copyright{
      font-size: 0.7rem;
    }

    .brand-icon{
      height: 32px;
      cursor: pointer;
    }
  }

</style>

<section id="footer">
    <div class="brand-icons">
        <a href="home.jsp"><img src="assets/brand/onetone.png" alt="AppIcon" class="brand-icon"></a>
        <a href="https://fezaitech.github.io/"><img src="assets/brand/fezai-tech.png" alt="FezaiTechIcon" class="brand-icon"></a>
    </div>
    <p class="brand-copyright">© Copyright 2024 FezaiTech Her Hakkı Saklıdır.</p>
    <p class="brand-text">One<span class="brand-color">To</span>One<span class="brand-color">Shop</span> <br> <span class="footer-italic">Size dair her şey</span></p>
</section>
