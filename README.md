
## certbot

### 申请证书

```bash
certbot --non-interactive --redirect --agree-tos --nginx -d woc.edk24.com -m edk24@qq.com
```

以上操作除了申请证书外，还可以自动添加https配置到nginx，很方便。

### 证书续期

```bash
certbot renew
```

添加到 `root` 用户的 `crontab` 里面就可以实现自动续期，距离到期时间太长会自动跳过续期

### 删除证书

```bash
certbot delete
```

## 参考

- [nginx 编译安装](https://juejin.cn/post/6844904134345228301)
- [php 编译安装](https://eyunzhu.com/1189)
- [使用certbot自动申请ssl证书](https://zahui.fan/posts/28c679c3/#%E5%AE%89%E8%A3%85certbot%E5%92%8Ccertbot-nginx-plugin)
