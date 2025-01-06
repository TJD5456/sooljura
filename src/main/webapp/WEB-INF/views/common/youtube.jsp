<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<style>
    .youtube {
        display: flex;
        border: 1px solid #ddd;
        background: #fff;
        border-radius: 8px;
        box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
        margin: 20px auto;
        padding: 16px;
        max-width: 800px;
    }

    .youtube iframe {
        flex: 1 1 60%;
        border: none;
        border-radius: 8px;
        margin-right: 16px;
    }

    .text {
        flex: 1 1 40%;
        display: flex;
        flex-direction: column;
        justify-content: space-between;
        padding: 8px 16px;
    }

    .youtube-content {
        margin-bottom: 16px;
        font-size: 1.1em;
        color: #333;
    }

    .related-products {
        display: flex;
        flex-wrap: wrap;
        gap: 8px;
        font-size: 0.9em;
        color: #555;
    }

    .related-products div img {
        width: 50px;
    }
</style>

<div class="youtube">
    <iframe width="560" height="315" src="${youtube.youtubeUrl}"
            title="YouTube video player"
            allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
            referrerpolicy="strict-origin-when-cross-origin" allowfullscreen>
    </iframe>

    <div class="text">
        <div class="youtube-content">
            ${youtube.content}
        </div>

        <%-- TODO: href 를 제품키를 이용한 주소로 만들것 --%>
        <div class="related-products">
            <div>
                <a href="${prod1.prodKey}">
                    <img src="/resources/upload/product_images/${prod1.imgPath}" alt="${prod1.imgNm}">
                </a>
            </div>
            <c:if test="${youtube.prodKey2 != null}">
                <div>
                    <a href="${prod2.prodKey}">
                        <img src="/resources/upload/product_images/${prod2.imgPath}" alt="${prod2.imgNm}">
                    </a>
                </div>
            </c:if>
            <c:if test="${youtube.prodKey3 != null}">
                <div>
                    <a href="${prod3.prodKey}">
                        <img src="/resources/upload/product_images/${prod3.imgPath}" alt="${prod3.imgNm}">
                    </a>
                </div>
            </c:if>
        </div>
    </div>
</div>
